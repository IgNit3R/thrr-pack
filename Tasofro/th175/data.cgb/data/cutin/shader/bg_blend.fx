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
	float2 screen_uv;
	screen_uv.x = input.position.x / resolution_x;
	screen_uv.y = input.position.y / resolution_y;

	float4 col = tex0.Sample(s0, input.texcord) * tex1.Sample(s1, input.texcord);
	col.a = input.color.a;

	return col;
}

