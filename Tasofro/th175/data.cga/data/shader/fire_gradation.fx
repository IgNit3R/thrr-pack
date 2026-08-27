//灼熱地獄用　キャラクター下部照り返し
Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 PS(PS_INPUT input) : SV_Target
{
	float4 outCol = g_tex.Sample(g_sampler, input.TexCd) ;
	if(input.TexCd.y < 0.5){
		outCol.r = 0;
		outCol.g = 0;
		outCol.b = 0;
	}
	else{
		outCol.r = (input.TexCd.y * 2) - 1.0;
		outCol.g = ((input.TexCd.y * 2) - 1.0) * 0.75;
		outCol.b = 0;
	}

	return outCol * input.Col;
}
