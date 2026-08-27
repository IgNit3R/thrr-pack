Texture2D tex0 : register(t0);
SamplerState s0 : register(s0);

Texture2D tex1 : register(t1);
SamplerState s1 : register(s1);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 output = saturate(input.color) * tex0.Sample(s0, input.texcord);
	
	float2 t1_uv;
	t1_uv.x = input.position.x / 640.0;
	t1_uv.y = input.position.y / 360.0;
	float4 t1_col = tex1.Sample(s1, t1_uv);
	
	if (output.r < 0.75)
	{
		output.a = 0.0;
	} else {
		if (output.r < 0.83)
		{
			output.r = 1.0;
			output.g = 1.0;
			output.b = 1.0;
			output.a = 0.5;
		} else
		if (output.r < 0.9)
		{
			output.r = 1.0;
			output.g = 1.0;
			output.b = 1.0;
			output.a = 0.65;
		} else {
			output.r = 1.0;
			output.g = 1.0;
			output.b = 1.0;
			output.a = 0.0;
		}
	}

	if (t1_col.a != 0.0) output.a = 0.0;

	return output * input.color;
}
