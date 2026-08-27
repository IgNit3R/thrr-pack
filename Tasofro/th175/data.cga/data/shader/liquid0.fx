Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

cbuffer ConstBuff : register(b0)
{
	float r1;	// outer edge
	float g1;
	float b1;
	float a1;

	float r2;	// boundary
	float g2;
	float b2;
	float a2;

	float r3;	// inner
	float g3;
	float b3;
	float a3;
};


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
		if (outCol.r < 0.83)
		{
			outCol.r = r1;
			outCol.g = g1;
			outCol.b = b1;
			outCol.a = a1;
		} else
		if (outCol.r < 0.9)
		{
			outCol.r = r2;
			outCol.g = g2;
			outCol.b = b2;
			outCol.a = a2;
		} else {
			outCol.r = outCol.b * r3;
			outCol.g = outCol.b * g3;
			outCol.b = outCol.b * b3;
			outCol.a = a3;
		}
	}

	return outCol;
}
