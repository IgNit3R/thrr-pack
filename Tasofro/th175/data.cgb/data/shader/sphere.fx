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
	float2 cord_n = input.texcord * 2.0 - 1.0;
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));
	
	float2 pick_uv = 0;
	if (dist < 1.0)
	{
		float angle = atan2(cord_n.y, cord_n.x);
		float r = pow(dist, 2.0);
		pick_uv.x = (cos(angle) * r + 1.0) * 0.5;
		pick_uv.y = (sin(angle) * r + 1.0) * 0.5;
	} else {
		discard;
	}

	float4 col = tex0.Sample(s0, pick_uv) * input.color;
	
	if (dist < 0.99)
	{
		col = col - float4(1, 1, 1, 1) * pick_uv.y * 1.1 + float4(1, 0, 0, 1) * (1.0 - pick_uv.y) * 0.55;
	}

	col.a = 1.0;

	return col;
}
