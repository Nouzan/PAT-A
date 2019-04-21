#include <iostream>
#include <string>

using namespace std;

string slice_string(const string &s, int begin, int end) {
    string sliced_string = "";
    for (int i = begin; i < end; i ++) {
        sliced_string += s[i];
    }
    return sliced_string;
}

string std_format_of_num(int num) {
    string _raw_num = to_string(num);
    string raw_num = _raw_num;
    string formatted_num = "";
    int len = _raw_num.size();
    bool minus = num < 0;
    if (minus) {
        raw_num = slice_string(_raw_num, 1, len);
        len --;
    }
    if (len <= 3) {
        formatted_num = raw_num;
    } else {
        for (int i = len - 3, j = len; i >= 0; j = i, i -= 3) {
            string piece = slice_string(raw_num, i, j);
            formatted_num = piece + formatted_num;
            if (i > 0) {
                formatted_num = ',' + formatted_num;
            }
            if (i < 3) {
                formatted_num = slice_string(raw_num, 0, i) + formatted_num;
            }
        }
    }
    if (minus) {
        formatted_num = '-' + formatted_num;
    }
    return formatted_num;
}

void test_slice_string() {
    string s;
    int begin, end;
    cin >> s;
    cin >> begin >> end;
    cout << slice_string(s, begin, end) << endl;
}

void answer() {
    int a, b;
    cin >> a >> b;
    cout << std_format_of_num(a + b) << endl;
}

int main() {
    answer();
    //test_slice_string();
    return 0;
}