Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 col = tex0.Sample(s0, input.texcord);

	float px_size = 1.0 / 1280.0;
	float py_size = 1.0 / 720.0;

	float4 r = tex0.Sample(s0, input.texcord + float2(px_size, 0));
	float4 l = tex0.Sample(s0, input.texcord + float2(-px_size, 0));
	float4 u = tex0.Sample(s0, input.texcord + float2(0, -py_size));
	float4 b = tex0.Sample(s0, input.texcord + float2(0, py_size));

	if (col.r + col.g + col.b < 0.3 && col.a > 0.5)
	{
		col.rgb = 0.0;
		col.a = 0.2;
	} else {
		col.rgb = 0.0;
		col.a = 0.0;
	}

	if (r.r + r.g + r.b < 0.3 && r.a > 0.5)
	{
		col.a += 0.2;
	}

	if (l.r + l.g + l.b < 0.3 && l.a > 0.5)
	{
		col.a += 0.2;
	}

	if (u.r + u.g + u.b < 0.3 && u.a > 0.5)
	{
		col.a += 0.2;
	}

	if (b.r + b.g + b.b < 0.3 && b.a > 0.5)
	{
		col.a += 0.2;
	}
	
	col.a *= input.color.a;

	return col;
}

