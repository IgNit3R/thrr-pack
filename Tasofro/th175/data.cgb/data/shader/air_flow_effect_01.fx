Texture2D t0: register(t0);
SamplerState s0 : register(s0);

Texture2D t1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float resolution_x;
	float resolution_y;
	float offset_u;
	float offset_v;
	float scale_u;
	float scale_v;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 uv2;
	uv2.x = input.position.x / resolution_x;
	uv2.y = input.position.y / resolution_y;
	
	uv2 = uv2 * 2.0 - 1.0 + 0.25;
	uv2.y += 1.0;

	float dist = sqrt(pow(uv2.x, 2) + pow(uv2.y, 2));
	float angle = atan2(uv2.y, uv2.x);

	float2 pickup_cursor;
	pickup_cursor.x = (((angle / 3.141592653589793238462643 + 1.0) * 0.5 + offset_u) * scale_u) % 1.0;
	pickup_cursor.y = ((dist / 1.4) * scale_v) % 1.0;
	
	float4 pick_color = t1.Sample(s1, pickup_cursor);
	return t0.Sample(s0, input.texcord) * pick_color * input.color;
}
