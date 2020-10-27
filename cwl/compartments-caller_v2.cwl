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
      separate: true
      prefix: "-i"
      position: 1

  reference_track:
    type: File
    inputBinding:
      separate: true
      prefix: "-r"
      position: 2

  outdir:
    type: string
    inputBinding:
      separate: true
      prefix: "-o"
      position: 3
    default: "."

  binsize:
    type: int
    inputBinding:
      separate: true
      prefix: "-b"
      position: 4

  contact_type:
    type: string
    inputBinding:
      separate: true
      prefix: "-c"
      position: 5

  num_eig_vec:
    type: int
    inputBinding:
      separate: true
      prefix: "-e"
      position: 6

  sort_metric:
    type: string
    inputBinding:
      separate: true
      prefix: "-c"
      position: 7

outputs:
  bwfile:
    type: File
    outputBinding:
      glob: "$(inputs.outdir + '/' + '*.bw')"

baseCommand: ["run-compartments-caller_v2.sh"]
