///arm_move_towards(x, y, len, pin, px, py);
/// @arg txx position to move towards
/// @arg tyy position to move towards
/// @arg lenlength to move each step
/// @arg pinwhether to pin or not (constrain to a position)
/// @arg pxx location to pin/constrain to
/// @arg pyy location to pin/constrain to

//only fill in the three first arguments if you want the arm to move freely.
//the last two arguments are where you want to pin the arm to.

var _tx  = argument[0], 
    _ty  = argument[1],
    _dir = point_direction(seg_x[seg_amount], seg_y[seg_amount], _tx, _ty),
    _len = min(argument[2], point_distance(seg_x[seg_amount], seg_y[seg_amount], _tx, _ty)),
    _pin = false,
    _pnx = x,
    _pny = y;

if (argument_count > 3) {
    _pin = argument[3];
    if (_pin) {
        if (argument_count > 4) {
            var _pnx = argument[4],
            _pny = argument[5];
        }
    }
} else _pin = arm_pinned;

if (_len != 0) {
    seg_x[@ seg_amount] += dcos(_dir)*_len;   
    seg_y[@ seg_amount] += dsin(360-_dir)*_len; 

    for(var _i = seg_amount-1; _i >= _pin; _i--) 
        seg_calculate(_i,seg_x[@ _i+1], seg_y[@ _i+1]);
}

if (_pin && (seg_x[@ 0] != _pnx || seg_y[@ 0] != _pny || _len != 0)) {
    seg_x[@ 0] = _pnx;
    seg_y[@ 0] = _pny;

    for(var _i = 1; _i <= seg_amount; _i++)
        seg_calculate(_i, seg_x[@ _i-1], seg_y[@ _i-1]);
}

return (seg_x[seg_amount] == _tx && seg_y[seg_amount] == _ty);

