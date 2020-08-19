* Encoding: UTF-8.

  
  
  
  * EXPERIMENT 1 analysis run on the following data files:
      * Exp1_Hotspot.sav for hotspot configurations
      * Exp1_Scrambled.sav for scrambled hotspot configurations
  

    GLM A_Dhs_Ghi_Dm A_Dhs_Ghi_Lm A_Dhs_Glo_Dm A_Dhs_Glo_Lm A_Lhs_Ghi_Dm A_Lhs_Ghi_Lm A_Lhs_Glo_Dm
    A_Lhs_Glo_Lm V_Dhs_Ghi_Dm V_Dhs_Ghi_Lm V_Dhs_Glo_Dm V_Dhs_Glo_Lm V_Lhs_Ghi_Dm V_Lhs_Ghi_Lm
    V_Lhs_Glo_Dm V_Lhs_Glo_Lm BY Group
  /WSFACTOR=ColorScale 2 Polynomial HotspotLightness 2 Polynomial LegendTextPosition 2 Polynomial
    Mapping 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=ColorScale HotspotLightness LegendTextPosition Mapping ColorScale*HotspotLightness
    ColorScale*LegendTextPosition HotspotLightness*LegendTextPosition
    ColorScale*HotspotLightness*LegendTextPosition ColorScale*Mapping HotspotLightness*Mapping
    ColorScale*HotspotLightness*Mapping LegendTextPosition*Mapping
    ColorScale*LegendTextPosition*Mapping HotspotLightness*LegendTextPosition*Mapping
    ColorScale*HotspotLightness*LegendTextPosition*Mapping
  /DESIGN=Group.

  
  
  * EXPERIMENT 2 analysis run on the following data files:
      *Exp2_BalancedImg.sav for balanced cue images
      
GLM A_Dhs_Ghi_Dm A_Dhs_Ghi_Lm A_Dhs_Glo_Dm A_Dhs_Glo_Lm A_Lhs_Ghi_Dm A_Lhs_Ghi_Lm A_Lhs_Glo_Dm
    A_Lhs_Glo_Lm V_Dhs_Ghi_Dm V_Dhs_Ghi_Lm V_Dhs_Glo_Dm V_Dhs_Glo_Lm V_Lhs_Ghi_Dm V_Lhs_Ghi_Lm
    V_Lhs_Glo_Dm V_Lhs_Glo_Lm
  /WSFACTOR=ColorScale 2 Polynomial HotspotLightness 2 Polynomial LegendTextPosition 2 Polynomial
    Mapping 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=ColorScale HotspotLightness LegendTextPosition Mapping ColorScale*HotspotLightness
    ColorScale*LegendTextPosition HotspotLightness*LegendTextPosition
    ColorScale*HotspotLightness*LegendTextPosition ColorScale*Mapping HotspotLightness*Mapping
    ColorScale*HotspotLightness*Mapping LegendTextPosition*Mapping
    ColorScale*LegendTextPosition*Mapping HotspotLightness*LegendTextPosition*Mapping
    ColorScale*HotspotLightness*LegendTextPosition*Mapping.

    *Exp2_HSmore.sav for hotspot more images
    
GLM A_Dhs_Ghi_Dm A_Dhs_Glo_Dm A_Lhs_Ghi_Lm A_Lhs_Glo_Lm V_Dhs_Ghi_Dm V_Dhs_Glo_Dm V_Lhs_Ghi_Lm
    V_Lhs_Glo_Lm
  /WSFACTOR=ColorScale 2 Polynomial Mapping 2 Polynomial LegendTextPosition 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=ColorScale Mapping LegendTextPosition ColorScale*Mapping ColorScale*LegendTextPosition
    Mapping*LegendTextPosition ColorScale*Mapping*LegendTextPosition.

  * EXPERIMENT 3 and 4 analysis run on the following data files:
      *Exp3_BalancedImg.sav for balanced cue images
      *Exp4_BalancedImg.sav for balanced cue images

GLM H_Dhs_Ghi_Dm H_Dhs_Ghi_Lm H_Dhs_Glo_Dm H_Dhs_Glo_Lm H_Lhs_Ghi_Dm H_Lhs_Ghi_Lm H_Lhs_Glo_Dm
    H_Lhs_Glo_Lm V_Dhs_Ghi_Dm V_Dhs_Ghi_Lm V_Dhs_Glo_Dm V_Dhs_Glo_Lm V_Lhs_Ghi_Dm V_Lhs_Ghi_Lm
    V_Lhs_Glo_Dm V_Lhs_Glo_Lm
  /WSFACTOR=ColorScale 2 Polynomial HotspotLightness 2 Polynomial LegendLTextPosition 2 Polynomial
    Mapping 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=ColorScale HotspotLightness LegendLTextPosition Mapping ColorScale*HotspotLightness
    ColorScale*LegendLTextPosition HotspotLightness*LegendLTextPosition
    ColorScale*HotspotLightness*LegendLTextPosition ColorScale*Mapping HotspotLightness*Mapping
    ColorScale*HotspotLightness*Mapping LegendLTextPosition*Mapping
    ColorScale*LegendLTextPosition*Mapping HotspotLightness*LegendLTextPosition*Mapping
    ColorScale*HotspotLightness*LegendLTextPosition*Mapping.

  * EXPERIMENT 3 and 4 analysis run on the following data files:
    *Exp3_HSmore.sav for hotspot more images
    *Exp4_HSmore.sav for hotspot more images

GLM H_Dhs_Ghi_Dm H_Dhs_Glo_Dm H_Lhs_Ghi_Lm H_Lhs_Glo_Lm V_Dhs_Ghi_Dm V_Dhs_Glo_Dm V_Lhs_Ghi_Lm
    V_Lhs_Glo_Lm
  /WSFACTOR=ColorScale 2 Polynomial Mapping 2 Polynomial LegendTextPosition 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=ColorScale Mapping LegendTextPosition ColorScale*Mapping ColorScale*LegendTextPosition
    Mapping*LegendTextPosition ColorScale*Mapping*LegendTextPosition.

