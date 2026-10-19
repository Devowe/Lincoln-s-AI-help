#!/usr/bin/env python3
"""THE LAST KLADRUBER — reproducible, dual-axis projection sculpture.

Dependencies: pip install numpy pillow cairosvg scipy scikit-image trimesh matplotlib
Usage: python build.py
Source silhouettes are hand-drawn SVGs in assets/. Geometric checks are saved
in previews/ and versions/. Distances in millimeters.
"""
from pathlib import Path
from io import BytesIO
import json
import math
import numpy as np
from PIL import Image
import cairosvg
from scipy import ndimage as ndi
from skimage import measure
import trimesh

ROOT = Path(__file__).resolve().parent
ASSETS = ROOT/'assets'
PV = ROOT/'previews'
PV.mkdir(exist_ok=True)


def mask_svg(name, resolution):
    # SVG viewBox fixed at 220 by 160; image Y increases downward, our Z up.
    data = cairosvg.svg2png(url=str(ASSETS/name),
                           output_width=round(220*resolution),
                           output_height=round(160*resolution))
    rgba = np.asarray(Image.open(BytesIO(data)).convert('RGBA'))
    # Black artwork counts as shadow; white overprinted details are true holes.
    mask = (rgba[:, :, 3] >= 127) & (rgba[:, :, :3].mean(axis=2) < 127)
    return mask[::-1, :].T  # x,z coordinate order


def save_model(occ, pitch, output_path):
    # One-voxel border makes marching-cubes surfaces closed even at extreme bounds.
    border = np.pad(occ.astype(np.uint8), 1)
    vertices, faces, normals, values = measure.marching_cubes(border, level=0.5, spacing=(pitch,)*3)
    vertices -= pitch
    mesh = trimesh.Trimesh(vertices=vertices, faces=faces[:, ::-1], process=True)
    mesh.remove_unreferenced_vertices()
    mesh.export(output_path, file_type='stl')
    return mesh


def build_projection(scale, pitch, base_height, name, single=False):
    nx = int(math.ceil(220*scale/pitch))
    nz = int(math.ceil(160*scale/pitch))
    factor = scale/pitch
    horse_raw = mask_svg('kladruber_horse.svg', factor)
    coach_raw = mask_svg('royal_carriage.svg', factor)
    # Make both masks exactly the same shape, allowing for Cairo rounding.
    horse = np.zeros((nx, nz), dtype=bool)
    coach = np.zeros((nx, nz), dtype=bool)
    horse[:min(nx,horse_raw.shape[0]), :min(nz,horse_raw.shape[1])] = horse_raw[:nx,:nz]
    coach[:min(nx,coach_raw.shape[0]), :min(nz,coach_raw.shape[1])] = coach_raw[:nx,:nz]
    # Align the lowest silhouette pixels directly with the plinth. Previously a
    # few millimeters of whitespace below the hooves left the stage unconnected.
    ground = min(int(np.flatnonzero(horse.any(axis=0))[0]),
                 int(np.flatnonzero(coach.any(axis=0))[0]))
    horse = horse[:,ground:]
    coach = coach[:,ground:]
    nz = horse.shape[1]
    if single:
        # An early flat, single-shadow proof of the horse's exact drawn silhouette.
        occ = np.zeros((nx, int(math.ceil(12/pitch)), nz+int(math.ceil(base_height/pitch))), dtype=bool)
        occ[:, 2:-2, int(math.ceil(base_height/pitch)):] = horse[:,None,:]
    else:
        # Orthogonal 'visual hull': project along Y -> horse; along X -> carriage.
        core = horse[:, None, :] & coach[None, :, :]
        occ = np.zeros((nx,nx,nz+int(math.ceil(base_height/pitch))),dtype=bool)
        occ[:,:,int(math.ceil(base_height/pitch)):] = core
    # Add a shallow integral ground stage to turn many disconnected foot contacts
    # into a single stable object, deliberately visible in both silhouettes.
    bh = int(math.ceil(base_height/pitch))
    if single:
        occ[:, :, :bh] = True
    else:
        # True flat base plate, all four corners gently chamfered in plan.
        inset = int(math.ceil(4/pitch))
        occ[inset:nx-inset, inset:nx-inset, :bh] = True
        for k in range(inset):
            occ[inset+k:nx-inset-k,inset-k:inset,:bh] = True
            occ[inset+k:nx-inset-k,nx-inset:nx-inset+k,:bh] = True
            occ[inset-k:inset,inset+k:nx-inset-k,:bh] = True
            occ[nx-inset:nx-inset+k,inset+k:nx-inset-k,:bh] = True
    # Connectivity check: only retain the largest solid printable object.
    labels, n = ndi.label(occ, structure=ndi.generate_binary_structure(3,1))
    counts = np.bincount(labels.ravel())
    if n:
        biggest = int(counts[1:].argmax()+1)
        dangling = int(occ.sum()-counts[biggest])
        occ = (labels==biggest)
    else:
        dangling = 0
    vdir = ROOT/'versions'/name
    vdir.mkdir(exist_ok=True,parents=True)
    out = vdir/('kladruber_flat_test.stl' if single else 'dual_shadow.stl')
    mesh = save_model(occ, pitch, out)
    # Check silhouette overlap where sculpture exists (exclude deliberate base).
    projected_h = np.any(occ[:,:,:][...,bh:],axis=1)
    projected_c = np.any(occ[:,:,bh:],axis=0)
    overlap_h = (projected_h & horse).sum()/max(1,horse.sum())
    overlap_c = (projected_c & coach).sum()/max(1,coach.sum()) if not single else 0
    # A proper check compares all drawn pixels, not just IoU.
    report = {
        'version':name,'model':'single-shadow flat horse' if single else 'dual-shadow visual hull',
        'pitch_mm':pitch,'scale':scale,'model_dimensions_mm':[round(v,2) for v in mesh.extents],
        'mesh_triangle_count':int(len(mesh.faces)),
        'watertight':bool(mesh.is_watertight),'connected_mesh_parts':len(mesh.split(only_watertight=False)),
        'volume_cm3_if_solid':round(float(mesh.volume/1000),1),
        'horse_shadow_coverage_fraction':round(float(overlap_h),4),
        'carriage_shadow_coverage_fraction':round(float(overlap_c),4),
        'discarded_disconnected_voxels':dangling,
        'disclaimer':'Digital orthographic shadow simulation, not physical LED field test. Support material and lamp divergence affect result.'
    }
    (vdir/'validation.json').write_text(json.dumps(report,indent=2)+'\n')
    # Black pixels = sculptural shadow, white = light.
    def mask_png(m, path):
        Image.fromarray((~m.T[::-1,:]).astype(np.uint8)*255,mode='L').save(path)
    mask_png(projected_h,PV/f'{name}_horse_projection.png')
    if not single:
        mask_png(projected_c,PV/f'{name}_carriage_projection.png')
    return report,mesh


def main():
    plans = [
        ('v01',0.63,1.30,4,True),
        ('v02',0.55,1.35,5,False),
        ('v03',0.90,1.15,6,False)
    ]
    reports=[]
    for ver,scale,pitch,base,single in plans:
        r,m=build_projection(scale,pitch,base,ver,single)
        print(json.dumps(r,indent=2))
        reports.append(r)
    (ROOT/'validation_summary.json').write_text(json.dumps(reports,indent=2)+'\n')

if __name__ == '__main__':
    main()
