#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: ""

- class: "InlineJavascriptRequirement"

inputs:
  mcoolfile:
    type: File
    inputBinding:
      position: 1

  binsize:
    type: int
    inputBinding:
      position: 2

  contact_type:
    type: string
    inputBinding:
      position: 3

  reference_track:
    type: 
    inputBinding:
      position: 4
      
  num_eig_vec:
    type: int
    inputBinding:
      position: 5
      
  outdir:
    type: string
    inputBinding:
      position: 6
    default: "."

outputs:
  bwfile:
    type: File
    outputBinding:
      glob: "$(inputs.outdir + '/' + '*.bw')"

baseCommand: ["run-insulator-score-caller.sh"]
