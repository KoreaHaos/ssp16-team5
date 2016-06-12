int red_min_val
int ylw_min_val

int return_one_for_red_two_for_yellOw_and_three_for_all_else(int value_to_calculate_on)
{
	if (value_to_calculate_on < red_min_val)
	{
		return 1;
	}
	else if (value_to_calculate_on < ylw_min_val)
	{
		return 2;
	}
	else
	{
		return 3;
	}
}

void add_values_to_array()
{
	
}