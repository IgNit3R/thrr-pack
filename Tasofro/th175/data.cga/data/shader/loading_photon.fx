Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 pos_norm = input.texcord - 0.5;
	float dist = (0.5 - sqrt(pos_norm.x * pos_norm.x + pos_norm.y * pos_norm.y)) * 2.0;

	if (dist > 1.0 || dist < 0.0)
	{
		discard;
	}

	float4 col;
	col.rgb = dist * dist * dist;
	col.a = input.color.a;

	float2 screen_uv;
	screen_uv.x = input.position.x / resolution_x;
	screen_uv.y = input.position.y / resolution_y;
	float4 bg_col = tex1.Sample(s1, screen_uv);

	float brightness = (dist * dist) * 0.5;
	brightness = min(1.0, max(0.0, brightness/* + brightness_delta*/));
	
	col = 1.0 - ((1.0 - bg_col) / brightness);
	col.a = input.color.a * 1.0;


	return col;
}
