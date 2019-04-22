#include <iostream>
#include <vector>
#include <iomanip>
using namespace std;

void input_poly(vector<double> &poly) {
    int k, last_r = -1;
    poly.clear();
    cin >> k;
    for (int i = 0; i < k; i ++) {
        int r;
        double s;
        cin >> r >> s;
        for (int j = last_r - 1; j > 0 && j != r; j --) {
            poly.push_back(0.0);
        }
        last_r = r;
        poly.push_back(s);
    }
    if (last_r > 0) {
        for (int j = last_r - 1; j >= 0; j --) {
            poly.push_back(0.0);
        }
    }
}

void print_poly(const vector<double> &poly, bool reverse=false) {
    int nz_count = 0;
    vector<double> _poly;
    for (int i = 0; i < poly.size(); i ++) {
        if (poly[i] != 0) {
            nz_count ++;
        }
    }
    cout << nz_count;
    int len = poly.size();
    for (int i = 0; i < len; i ++) {
        int j = i;
        if (reverse) {
            j = len - i - 1;
        }
        if (poly[j] != 0) {
            int k = len - i - 1;
            if (reverse) {
                k = j;
            }
            cout << setiosflags(ios::fixed) << setprecision(1) << " " << k << " " << poly[j];
        }
    }
    cout << endl;
}

void answer() {
    vector<double> stack_a, stack_b, stack_ans;
    
    // input A
    input_poly(stack_a);
    
    // input B
    input_poly(stack_b);

    //print_poly(stack_a);
    //print_poly(stack_b);

    // calc
    while (stack_a.size() != 0 && stack_b.size() != 0) {
        double s_a = stack_a.back(), s_b = stack_b.back(), ans;
        int nz_count = 0;
        stack_a.pop_back(); stack_b.pop_back();
        ans = s_a + s_b;
        stack_ans.push_back(ans);
    }

    // pop the least
    while (stack_a.size() != 0) {
        stack_ans.push_back(stack_a.back());
        stack_a.pop_back();
    }

    while (stack_b.size() != 0) {
        stack_ans.push_back(stack_b.back());
        stack_b.pop_back();
    }

    //output ans
    print_poly(stack_ans, true);
}

int main() {
    answer();
    return 0;
}