Texture2D tex0 : register(t0);
SamplerState s0 : register(s0);

Texture2D tex1 : register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float r1;	// outer edge
	float g1;
	float b1;
	float a1;

	float r2;	// boundary
	float g2;
	float b2;
	float a2;

	float r3;	// inner
	float g3;
	float b3;
	float a3;

	float transparent;
	float frame;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 output = saturate(input.color) * tex0.Sample(s0, input.texcord);
	float4 src_color = output;
	
	
	float2 t1_uv;
	t1_uv.x = (input.position.x / 640.0 + sin(input.position.y * 0.3 + frame) * 0.005 + 1.0) % 1.0;
	t1_uv.y = input.position.y / 360.0;
	float4 t1_col = tex1.Sample(s1, t1_uv);

	if (output.r < 0.80)
	{
		output.a = 0.0;
		return output;
	} else {
		if (output.r < 0.83)
		{
			output.r = r1;
			output.g = g1;
			output.b = b1;
			output.a = a1;
		} else
		if (output.r < 0.9)
		{
			output.r = r2;
			output.g = g2;
			output.b = b2;
			output.a = a2;
		} else {
			output.r = output.b * r3;
			output.g = output.b * g3;
			output.b = output.b * b3;
			output.a = a3;
		}
	}

	float a = 0.8;
	if ((t1_col.r + t1_col.g + t1_col.b) / 3.0 < 0.5)
	{
		a = 0.4;
	}

	output.rgb = (output.rgb * output.a * 0.8 + (t1_col.rgb * transparent - (1.0 - output.rgb) * a)) / 1.0 * (src_color.r * src_color.r);
	output.a *= 2.0;

	return output * input.color;
}
