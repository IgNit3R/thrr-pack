Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 pos : SV_POSITION;
	float4 col : COLOR;
	float2 tex_cord : TEXCOORD0;
};


float4 PS(PS_INPUT input) : SV_Target
{
	float4 col = g_tex.Sample(g_sampler, input.tex_cord);

	// scanline
	float py = round((input.tex_cord.y * 1080) + 0.5);
	if ((py % 3) == 0)
	{
		col -= float4(0.14, 0.14, 0.14, 0);
	} else {
		// rgb pattern
		float px = round((input.tex_cord.x * 1920) + 0.5);
		switch (px % 3)
		{
			case 0:
				col -= float4(0, 0.09, 0.09, 0);
				break;
			case 1:
				col -= float4(0.09, 0, 0.09, 0);
				break;
			case 2:
				col -= float4(0.09, 0.09, 0, 0);
				break;
		}
	}
	col += float4(0.025, 0.025, 0.025, 0);

	return col;
}
