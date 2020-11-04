#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: "4dndcic/4dn-compartments-caller:test_v2"

- class: "InlineJavascriptRequirement"

inputs:
  mcoolfile:
    type: File
    inputBinding:
      position: 1

  reference_track:
    type: File
    inputBinding:
      position: 2

  outdir:
    type: string
    inputBinding:
      position: 3
    default: "."

  binsize:
    type: int
    inputBinding:
      position: 4

  contact_type:
    type: string
    inputBinding:
      position: 5

  num_eig_vec:
    type: int
    inputBinding:
      position: 6
    default: 3

  sort_metric:
    type: string
    inputBinding:
      position: 7

  clip_percentile:
    type: float
    inputBinding:
      position: 8

outputs:
  bwfile:
    type: File
    outputBinding:
      glob: "$(inputs.outdir + '/' + '*.bw')"

baseCommand: ["run-compartments-caller_v2.sh"]
