#include <bits/stdc++.h>

using namespace std;

struct Node {
  int val, id;
  Node *pre, *nxt;
};

void move_forward(Node *node) {
  node->pre->nxt = node->nxt;
  node->nxt->pre = node->pre;
  node->nxt = node->nxt->nxt;
  node->pre = node->nxt->pre;
  node->nxt->pre = node->pre->nxt = node;
}

void move_backward(Node *node) {
  node->pre->nxt = node->nxt;
  node->nxt->pre = node->pre;
  node->pre = node->pre->pre;
  node->nxt = node->pre->nxt;
  node->pre->nxt = node->nxt->pre = node;
}

const int N = 5000;
const int special = 811589153;

int main() {
  vector<int> nums;
  vector<Node *> nodes;
  for (int i = 0; i < N; ++i) {
    int num;
    cin >> num;
    nums.push_back(num);
    nodes.push_back(new Node{num, i, nullptr, nullptr});
  }

  for (int i = 0; i < N; ++i) {
    nodes[i]->pre = nodes[(i - 1 + N) % N];
    nodes[i]->nxt = nodes[(i + 1) % N];
  }

  for (int i = 0; i < N; ++i) {
    int num = nums[i];
    for (Node *node : nodes) {
      if (node->val == num && node->id == i) {
        if (num > 0) {
          for (int i = 0; i < num; ++i)
            move_forward(node);
        } else {
          for (int i = 0; i < -num; ++i)
            move_backward(node);
        }
        break;
      }
    }
  }

  int i = 0;
  while (nodes[i]->val != 0)
    i++;
  Node *p = nodes[i];

  int ans = 0;
  for (int k = 0; k < 3; ++k) {
    for (int i = 0; i < 1000; ++i) {
      p = p->nxt;
    }
    ans += p->val;
  }

  cout << "Part 1: " << ans << endl;

  nodes.clear();
  for (int i = 0; i < N; ++i) {
    nodes.push_back(new Node{nums[i], i, nullptr, nullptr});
  }

  for (int i = 0; i < N; ++i) {
    nodes[i]->pre = nodes[(i - 1 + N) % N];
    nodes[i]->nxt = nodes[(i + 1) % N];
  }

  for (int k = 0; k < 10; ++k)
    for (int i = 0; i < N; ++i) {
      int num = nums[i];
      for (Node *node : nodes) {
        if (node->val == num && node->id == i) {
          if (num > 0) {
            for (int i = 0; i < 1LL * num * special % (N - 1); ++i)
              move_forward(node);
          } else {
            for (int i = 0; i < 1LL * -num * special % (N - 1); ++i)
              move_backward(node);
          }
          break;
        }
      }
    }

  p = nodes[i];
  ans = 0;
  for (int k = 0; k < 3; ++k) {
    for (int i = 0; i < 1000; ++i) {
      p = p->nxt;
    }
    ans += p->val;
  }

  cout << "Part 2: " << 1LL * ans * special << endl;
}
