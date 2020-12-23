#include <iostream>
#include <set>
#include <unordered_map>
#include <vector>

using namespace std;

struct Node {
  Node *next;
  int val;
  Node(int val) : val(val), next(nullptr) {}
};

Node *build(vector<int> arr) {
  Node *sentinel = new Node(0);
  Node *p = sentinel;
  for (int i : arr) {
    p->next = new Node(i);
    p = p->next;
  }
  p->next = sentinel->next;
  return sentinel->next;
}

int main() {
  vector<int> cups{9, 2, 5, 1, 7, 6, 8, 3, 4};
  int N = 1e6, T = 1e7;
  while (cups.size() < N)
    cups.emplace_back(cups.size() + 1);

  Node *p = build(cups);
  unordered_map<int, Node *> dict;
  dict[p->val] = p;
  Node *q = p->next;
  while (q != p) {
    dict[q->val] = q;
    q = q->next;
  }
  for (int i = 0; i < T; ++i) {
    Node *l = p->next;
    Node *r = p->next->next->next;
    p->next = r->next;
    set<int> s{l->val, l->next->val, r->val};
    int dest = p->val - 1;
    if (dest == 0)
      dest = N;
    while (s.count(dest)) {
      dest--;
      if (dest == 0)
        dest = N;
    }
    Node *pos = dict[dest];
    r->next = pos->next;
    pos->next = l;
    p = p->next;
  }

  Node *one = dict[1];
  cout << 1LL * one->next->val * one->next->next->val;
}