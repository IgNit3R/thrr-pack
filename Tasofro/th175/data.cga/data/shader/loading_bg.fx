Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

cbuffer ConstBuff : register(b0)
{
	float brightness_delta;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float y = input.position.y + (input.position.x / resolution_x) * 60.0 - 30.0;
	float brightness = 1.0 - y / resolution_y;
	
	brightness = min(1.0, max(0.0, brightness + brightness_delta));

	float4 col = tex0.Sample(s0, input.texcord) * input.color;
	
	col.rgb *= 1.0 - ((1.0 - col) / brightness);
	
	float grad = ((input.position.x / resolution_x + input.position.y / resolution_y) / 2.0);
	float grad2 = (1.0 - grad) * (1.0 - grad) * 0.1 + (1.0 - grad) * 0.5;

	col.rgb -= grad2;

	return col;
}
