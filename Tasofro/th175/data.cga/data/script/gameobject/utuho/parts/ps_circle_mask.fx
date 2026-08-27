Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
	float psize : PSIZE;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 cord = (input.texcord - 0.5) * 2.0;
	float dist = pow(cord.x, 2) + pow(cord.y, 2);

	if (dist > 1.0)
	{
		discard;
	}
	
	float4 out_col = /*tex0.Sample(s0, input.texcord) **/ input.color;
//	return tex0.Sample(s0, input.texcord) * input.color;

	if (dist > 0.75)
	{
		out_col.a = (1.0 - dist) * 2.0;
		out_col.r = 1;
		out_col.g = 0;
		out_col.b = 0;
	} else {
		out_col.r = 1;
		out_col.g = 0.75;
		out_col.b = 0.2;
	}

	return out_col;
}
