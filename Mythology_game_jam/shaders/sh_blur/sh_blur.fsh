// Motion blur shader
precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniform vector 2 of movement velocity
uniform vec2 u_velo;

// Main function
void main()
{
	// Blur quality low
    float _quality = 4.0;

	// Empty colour variable
    vec4 _colour = vec4(0, 0, 0, 0);
    
	// Loops through quality with the index being a faction based on the quality under 1
	for (float _i = 0.0; _i < 1.0; _i += 1.0 / _quality)
	{
		// Adds the texture of the coordiate plus a fraction of the velocity
		_colour += texture2D(gm_BaseTexture, v_vTexcoord + (u_velo * 0.05) * _i);	
	}
    
	// The total colour value is then devided by the quality
	_colour = _colour / _quality;
	
	// The new shader output is the new colour times the original value
    gl_FragColor =  _colour * v_vColour;
}