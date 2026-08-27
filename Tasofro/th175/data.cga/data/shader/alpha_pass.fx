Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float threshold;
};
struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 col = tex0.Sample(s0, input.texcord) * input.color;
	float4 mask = tex1.Sample(s1, input.texcord);

	if (threshold < 0.98 && mask.r >= threshold)
	{
		if (mask.r - threshold < 0.002)
		{
			return float4(1.0, 0.1, 0.0, 1.0);
		}
		if (mask.r - threshold < 0.015)
		{
			return float4(0.75, 0.2, 0.2, 0.8);
		}
		if (mask.r - threshold < 0.03)
		{
			return float4(0.5, 0.0, 0.0, 0.8);
		}
	}
/*
	if (threshold < 0.98 && abs(mask.r - threshold) < 0.01)
	{
		return float4(0.9, 0, 0, 1.0);
	}
*/
	if (mask.r > threshold)
	{
		col.a = 0;
	}

	return col;
}
