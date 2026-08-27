Texture2D tex0: register(t0);
SamplerState sampler0: register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcoord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 col = tex0.Sample(sampler0, input.texcoord);

	float contrast = 3.5f;
	col.a = min((col.r - 0.5f) * max(contrast, 0.0f) + 0.5f, 1.0f);
	
/*
	if (col.a < 0.5)
	{
		discard;
	}
*/
	col.r = 1.0;
	col.g = 1.0;
	col.b = 1.0;

	return input.color * col;
}
