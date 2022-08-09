Shader "Custom/CYMKToRGB"
{
    Properties
    {
        _C ("C",Float) = 1.0
        _M ("M",Float) = 1.0
        _Y ("Y",Float) = 1.0
        _K ("K",Float) = 1.0
    }
    SubShader
    {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float _C;
            float _M;
            float _Y;
            float _K;
            float _Alpha;

            float transformCYMKToRGB(float color) {
                return 1.0 * (1-color/1.0) * (1-_K/1.0);
            }

            float4 vert(float4 vertexPos:POSITION): SV_POSITION {
                return UnityObjectToClipPos(vertexPos);
            }

            float4 frag(): Color {
                float r = transformCYMKToRGB(_C);
                float g = transformCYMKToRGB(_M);
                float b = transformCYMKToRGB(_Y);

                return float4(r,g,b,_K);
            }
            
            ENDCG
        }

    }
    FallBack "Diffuse"
}
