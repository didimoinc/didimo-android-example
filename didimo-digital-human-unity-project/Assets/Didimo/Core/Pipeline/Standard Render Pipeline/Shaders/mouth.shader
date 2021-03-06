
Shader "Didimo/SRP/mouth"
{
  Properties
  {
    /// diffuse
    colorSampler ("Color Map", 2D) = "white" {}
    _darken ("Darken", Range(0,1)) = 1

    /// spec
    SpecColor ("Specular Color", Color) = (0.329, 0.626, 0.988, 1)
    roughness ("Roughness", Range(0,1)) = 0.2
    fresnel ("Fresnel", Range(0,1)) = 0.69

    /// geo
    normalSampler ("Normal Map", 2D) = "blue" {}
    height ("Height", Range(0,5)) = 1.1

    aoSampler ("Occlusion Map", 2D) = "white" {}
    aoInt ("Occlusion", Range(0,1)) = 0.371

    zBias ("Z Bias", Range(-1,1)) = 0

    directDiffInt ("Direct Diffuse Intensity", Range(0,1)) = 1
    indirectDiffInt ("Indirect Diffuse Intensity", Range(0,1)) = 1
    directSpecInt ("Direct Specular", Range(0,1)) = 1
    indirectSpecInt ("Indirect Specular", Range(0,1)) = 1

  }
  SubShader
  {
    Tags { 
      "RenderType" = "Opaque" 
    }
    LOD 100

    Pass
    {
      Tags { 
        "LightMode"="ForwardBase"
      }
      Cull Back
      CGPROGRAM
      #pragma multi_compile_fwdbase
      #define DIDIMO_SKIN
      #include "didimoCommon.cginc"
      #include "didimoLighting.cginc"
      #pragma vertex didimoVertFwdBase
      #pragma fragment frag
      
      sampler2D colorSampler;
      half _darken;

      fixed3 SpecColor;
      half roughness;
      half fresnel;

      sampler2D normalSampler;
      half height;

      sampler2D aoSampler;
      half aoInt;
 
      fixed4 _LightColor0;

      fixed4 frag(v2fbase i) : SV_Target
      {
        half3 tN = getTsNormal(normalSampler, i.uv, height);

        float3x3 tS = float3x3(i.wT, i.wB, i.wN);

        half3 tV = normalize(mul(tS, i.wV));

        float3 tD = getLightDir(i.wP, tS);
        UNITY_LIGHT_ATTENUATION(attenuation, i, i.wP);

        /// direct lighting
        fixed3 diffuse = fixed3(0, 0, 0);
        half3 spec = half3(0, 0, 0);

        diffuse = evalLambert(tD, tN) * _LightColor0 * attenuation;
        spec = evalSkinSpec(tD, tN, tV, roughness) * _LightColor0 * attenuation;

        diffuse *= directDiffInt;

        spec *= directSpecInt * evalFresnel(fresnel, tN, tV);

        /// indirect
        half3 wN = normalize(mul(tN, tS));
        diffuse += evalIndDiffuse(wN, i.wP);

        half3 indSpec = evalIndSpec(wN, i.wV, roughness);
        spec += indSpec * evalFresnel(fresnel, tN, tV);

        diffuse *= tex2D(colorSampler, i.uv) * _darken;

        spec *= SpecColor;

        fixed aoMap = tex2D(aoSampler, i.uv).r;
        half ao = lerp(1, aoMap, aoInt);
        diffuse *= ao;
        spec *= ao;

        return fixed4(diffuse + spec, 1.0f);
      }
      ENDCG
    }

    Pass
    {
      Tags { 
        "LightMode"="ForwardAdd"
      }
      Blend One One // additive blending 
      Cull Back
      CGPROGRAM
      #pragma multi_compile_fwdadd_fullshadows
      #define DIDIMO_SKIN
      #include "didimoCommon.cginc"
      #include "didimoLighting.cginc"
      #pragma vertex didimoVertFwdAdd
      #pragma fragment frag
      
      sampler2D colorSampler;
      half _darken;

      fixed3 SpecColor;
      half roughness;
      half fresnel;

      sampler2D normalSampler;
      half height;

      sampler2D aoSampler;
      half aoInt;
 
      fixed4 _LightColor0;

      fixed4 frag(v2fadd i) : SV_Target
      {
        half3 tN = getTsNormal(normalSampler, i.uv, height);

        float3x3 tS = float3x3(i.wT, i.wB, i.wN);

        half3 tV = normalize(mul(tS, i.wV));

        /// direct lighting
        float3 tD = getLightDir(i.wP, tS);
        UNITY_LIGHT_ATTENUATION(attenuation, i, i.wP);

        fixed3 diffuse = fixed3(0, 0, 0);
        half3 spec = half3(0, 0, 0);

        diffuse = evalLambert(tD, tN) * _LightColor0 * attenuation;
        spec = evalSkinSpec(tD, tN, tV, roughness) * _LightColor0 * attenuation;

        diffuse *= directDiffInt;

        spec *= directSpecInt * evalFresnel(fresnel, tN, tV);

        diffuse *= tex2D(colorSampler, i.uv) * _darken;

        spec *= SpecColor;

        fixed aoMap = tex2D(aoSampler, i.uv).r;
        half ao = lerp(1, aoMap, aoInt);
        diffuse *= ao;
        spec *= ao;

        return fixed4(diffuse + spec, 1.0f);
      }
      ENDCG
    }

  }

  Fallback "Standard"
}
