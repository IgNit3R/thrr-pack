Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 fog = tex1.Sample(s1, input.texcord);
	float4 col = tex0.Sample(s0, input.texcord);
	
	if (col.r + fog.r < 1.0)
	{
		col = 0.0;
	} else {
		col = 1.0;
	}

	return col;
}
