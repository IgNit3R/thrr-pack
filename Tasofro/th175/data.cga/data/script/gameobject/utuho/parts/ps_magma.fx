Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 Tex : TEXCOORD0;
};

float4 PS(PS_INPUT input) : SV_Target
{
	float4 outCol = saturate(input.Col) * g_tex.Sample(g_sampler, input.Tex);

	if (outCol.r < 0.80)
	{
		outCol.a = 0.0;
	} else {
		if (outCol.r < 0.6)
		{
			outCol.r = 0.0;//0.9;
			outCol.g = 0.0;//0.9;
			outCol.b = 0.0;//1.0;
			outCol.a = 0.7;
		} else
		if (outCol.r < 0.9)
		{
			outCol.r = 0.3;//0.9;
			outCol.g = 0.0;//0.9;
			outCol.b = 0.0;//1.0;
			outCol.a = 0.85;
		} else {
			outCol.r = 0.6;//outCol.b * 0.2;
			outCol.g = 0.25;//outCol.b * 0.2;
			outCol.b = 0.1;//outCol.b * 0.6;
			outCol.a = 0.95;//0.4;
		}
	}
	
	outCol *= input.Col;

	return outCol;
}
