!(register-module! ../../../../../../../metta-attention)
!(import! &self metta-attention:attention:agents:mettaAgents:AttentionParam)
!(import! &self metta-attention:attention-bank:utilities:helper-functions)
!(import! &self metta-attention:attention-bank:attention-value:getter-and-setter)
!(import! &self metta-attention:attention-bank:bank:atom-bins:atombins)
!(import! &self metta-attention:attention-bank:bank:attention-bank)
!(import! &self metta-attention:attention-bank:bank:attentional-focus:attentional-focus)
!(import! &self metta-attention:attention-bank:bank:importance-index:importance-index)
!(import! &self metta-attention:attention:agents:mettaAgents:Neighbors)
!(import! &self metta-attention:attention:agents:mettaAgents:ImportanceDiffusionAgent:ImportanceDiffusionBase:ImportanceDiffusionBase)
!(import! &self metta-attention:attention:agents:mettaAgents:ImportanceDiffusionAgent:AFImportanceDiffusionAgent:AFImportanceDiffusionAgent)

;;This are the same tests as the c++

;########################## Stimlating atoms so that they enter AF #############################
!(stimulate source 500)
!(stimulate target1 400)
!(stimulate target2 400)
!(stimulate target3 400)
!(stimulate target4 400)
!(stimulate target5 400)
!(stimulate target6 0)

;########################## Creating links between atoms #############################
!(setStv (HEBBIAN_LINK source target1) (0 1))
!(setStv (HEBBIAN_LINK source target2) (0 1))
!(setStv (ASYMMETRIC_HEBBIAN_LINK source target3) (0.6 0.1))
!(setStv (ASYMMETRIC_HEBBIAN_LINK source target4) (0.5 0.1))

!(setStv (INHERITANCE_LINK target3 source) (0 1))
!(setStv (INHERITANCE_LINK source target4) (0 1))
!(setStv (ASYMMETRIC_HEBBIAN_LINK target1 target2) (0 1))

!(setStv (ASYMMETRIC_HEBBIAN_LINK target2 target3) (0 1))
!(setStv (INHERITANCE_LINK source target5) (0 1))
!(setStv (INHERITANCE_LINK source target6) (0 1))
!(setStv (INHERITANCE_LINK (ASYMMETRIC_HEBBIAN_LINK source target4) target8) (0 1))
!(setStv (INHERITANCE_LINK target3 (ASYMMETRIC_HEBBIAN_LINK sorce target4)) (0 1))



;########################## Running the AF Importance Diffusion Agent #############################
!(AFImportanceDiffusionAgent-Run (attentionalFocus) (TypeSpace))
;########################## Testing the STI values #############################
!(assertEqual (getSTI source) 6000.0)
!(assertEqual (getSTI target1) 8000.0)
!(assertEqual (getSTI target2) 8000.0)
!(assertEqual (getSTI target3) 4803.0)
!(assertEqual (getSTI target4) 4802.5)
!(assertEqual (getSTI target5) 4800.0)
!(assertEqual (getSTI target6) 0.0)
!(assertEqual (getSTI target7) 0.0)
!(assertEqual (getSTI target8) 0.0)

!(assertEqual (getSTI (HEBBIAN_LINK source target1)) 0)
!(assertEqual (getSTI (HEBBIAN_LINK source target2)) 0)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK source target3)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK source target4)) 4198.625)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK target1 target2)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK source target5)) 4198.625)
!(assertEqual (getSTI (INHERITANCE_LINK source target6)) 998.625)
!(assertEqual (getSTI (INHERITANCE_LINK target3 source)) 2598.625)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK target2 target3)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK target3 (ASYMMETRIC_HEBBIAN_LINK sorce target4))) 1600)

; ;########################## Running the AF Importance Diffusion Agent #############################
!(AFImportanceDiffusionAgent-Run (attentionalFocus) (TypeSpace))
; ;########################## Testing the STI values #############################
!(assertEqual (getSTI source) 5998.9000000000015)
!(assertEqual (getSTI target1) 8000.0)
!(assertEqual (getSTI target2) 8000.0)
!(assertEqual (getSTI target3) 4043.3250000000003)
!(assertEqual (getSTI target4) 3722.7250000000004)
!(assertEqual (getSTI target5) 3719.7250000000004)
!(assertEqual (getSTI target6) 199.72500000000002)
!(assertEqual (getSTI target7) 0.0)
!(assertEqual (getSTI target8) 0.0)

!(assertEqual (getSTI (HEBBIAN_LINK source target1)) 0)
!(assertEqual (getSTI (HEBBIAN_LINK source target2)) 0)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK source target3)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK source target4)) 5039.35)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK target1 target2)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK source target5)) 5038.35)
!(assertEqual (getSTI (INHERITANCE_LINK source target6)) 1198.35)
!(assertEqual (getSTI (ASYMMETRIC_HEBBIAN_LINK target2 target3)) 0)
!(assertEqual (getSTI (INHERITANCE_LINK target3 (ASYMMETRIC_HEBBIAN_LINK sorce target4))) 1920.6)
