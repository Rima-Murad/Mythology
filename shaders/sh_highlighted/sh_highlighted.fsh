// Highlighted shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Main Function
void main()
{
	// Creates value based from original texture colour and coordinate
	vec4 _colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Outputs white value with alpha channel coming from the original
    gl_FragColor = vec4(1, 1, 1, _colour[3]);
}
