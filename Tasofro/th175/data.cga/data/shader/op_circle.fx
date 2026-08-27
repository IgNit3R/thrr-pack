Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

cbuffer ConstBuff : register(b0)
{
	float scale;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 pos_norm = input.texcord - 0.5;
	float dist = sqrt(pos_norm.x * pos_norm.x + pos_norm.y * pos_norm.y) * 2.0;

	if (dist > 1.0 || dist < 0.82)
	{
		discard;
	}

	float2 screen_uv;
	screen_uv.x = input.position.x / resolution_x;
	screen_uv.y = input.position.y / resolution_y;
	screen_uv = (screen_uv - 0.5) / scale + 0.5;
	float4 bg_col = tex1.Sample(s1, screen_uv);

	float alpha = 1.0;//(dist - 0.8) * 5.0;

	float4 col;
	col.rgb = (1.0 - bg_col.rgb) * alpha + bg_col.rgb * (1.0 - alpha);
	col.a = 1.0;

	return col;
}
