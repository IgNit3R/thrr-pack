Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

cbuffer ConstBuff : register(b0)
{
	float cord_px;		// unit of pixel
	float cord_py;
	float thickness;	// border width
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 center_col = tex0.Sample(s0, input.texcord);

	float contrast = 3.8f;//3.5f;
	center_col.a = min((center_col.r - 0.5f) * max(contrast, 0.0f) + 0.5f, 1.0f);
	
	if (center_col.r != 1.0 && thickness != 0)
	{
		float dx = cord_px;
		float dy = cord_py;
		int area_size = int(thickness) + 1;

		if (area_size < 1) area_size = 1;
		if (area_size > 16) area_size = 16;

		int hit_count = 0;
		float sum_alpha = 0.0;

		for (int x = -area_size; x <= area_size; x++)
		{
			for (int y = -area_size; y <= area_size; y++)
			{
				if (sqrt(x * x + y * y) <= thickness)
				{
					float4 pick_color = tex0.SampleLevel(s0, input.texcord + float2(dx * x, dy * y), 0);

					if (pick_color.r >= 0.35)//0.675)
					{
						center_col.a = 1.0;
						center_col.r = 1.0;
						center_col.g = 1.0;
						center_col.b = 1.0;
						hit_count++;
					}
					
					sum_alpha += pick_color.r;
				}
			}
		}
		
		if (hit_count > 0) center_col.a = center_col.a * 0.5 + (center_col.a * sum_alpha) * 0.5;
	} else {
		center_col.a = 1.0;
		center_col.r = 1.0;
		center_col.g = 1.0;
		center_col.b = 1.0;
	}

	return saturate(input.color) * center_col;
}
