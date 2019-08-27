#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: "4dndcic/4dn-compartments-caller:v1.1"

- class: "InlineJavascriptRequirement"

inputs:
  mcoolfile:
    type: File
    inputBinding:
      separate: true
      prefix: "-i"
      position: 1

  outdir:
    type: string
    inputBinding:
      separate: true
      prefix: "-o"
      position: 2
    default: "."

  binsize:
    type: int
    inputBinding:
      separate: true
      prefix: "-b"
      position: 3

  contact_type:
    type: string
    inputBinding:
      separate: true
      prefix: "-c"
      position: 4

  num_eig_vec:
    type: int
    inputBinding:
      separate: true
      prefix: "-e"
      position: 5

  reference_track:
    type:
      -"null"
      -"File"
    inputBinding:
      separate: true
      prefix: "-r"
      position: 6

outputs:
  bwfile:
    type: File
    outputBinding:
      glob: "$(inputs.outdir + '/' + '*.bw')"

baseCommand: ["run-compartments-caller.sh"]
