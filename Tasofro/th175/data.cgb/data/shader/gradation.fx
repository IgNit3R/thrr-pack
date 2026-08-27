
Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 outCol = g_tex.Sample(g_sampler, input.TexCd) ;
	if(input.TexCd.y < 0.33){
		outCol.r = 0.0;
		outCol.g = 0.0;
		outCol.b = 0.0;
	}
	else{
		outCol.rgb *= (input.TexCd.y * 1.5 - 0.5);
//		outCol.r = c_;
//		outCol.g = c_;
//		outCol.b = c_;
//		outCol.a = 0;
	}

	return outCol * input.Col;
}
