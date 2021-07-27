///numPad(num, padChar, padCount);

var num = string(floor(argument0));

if(string_length(num) < argument2)
{
    repeat(argument2-1)
    {
        num = argument1 + num;
    }
}

return num;
