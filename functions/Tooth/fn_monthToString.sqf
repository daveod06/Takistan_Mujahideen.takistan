// date = Array - date in format [year, month, day, hour, minute], where:
_monthNum = date select 1;
_monthStr = "";

switch (_monthNum) do
{
    case 1: { _monthStr = "January" };
    case 2: { _monthStr = "Feburary" };
    case 3: { _monthStr = "March" };
    case 4: { _monthStr = "April" };
    case 5: { _monthStr = "May" };
    case 6: { _monthStr = "June" };
    case 7: { _monthStr = "July" };
    case 8: { _monthStr = "August" };
    case 9: { _monthStr = "September" };
    case 10: { _monthStr = "October" };
    case 11: { _monthStr = "November" };
    case 12: { _monthStr = "December" };
    default {_monthStr = ""};
};

_monthStr
