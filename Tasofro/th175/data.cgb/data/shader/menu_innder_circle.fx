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
	float2 cord_n = float2(1.85 - input.texcord.x - 0.2, 1.85 - input.texcord.y - 0.33);
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));

	if (dist < 1.8)
	{
		discard;
	}

	// refraction
	float2 offset = float2(0, 0);
	float px_size = 1.0 / 256.0;

	float4 r = tex1.Sample(s1, input.texcord + float2(px_size, 0));
	float4 l = tex1.Sample(s1, input.texcord + float2(-px_size, 0));
	float4 u = tex1.Sample(s1, input.texcord + float2(0, -px_size));
	float4 b = tex1.Sample(s1, input.texcord + float2(0, px_size));
	
	offset = float2(r.r - l.r, u.r - b.r);
	offset *= px_size * 100.0;

	float4 col = tex0.Sample(s0, input.texcord + offset) * input.color;
//	col.a = 1.0;

	return col;
}

