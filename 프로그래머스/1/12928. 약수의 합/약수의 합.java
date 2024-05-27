class Solution {
    public int solution(int n) {
        int answer = 0;
        for(int i=1; i*i<=n; i++) {
            // n/i의 나머지가 0인 경우
            if(n%i==0) {
                if(i*i==n) answer+=i;
                else answer += i+(n/i);
            }
        }
        return answer;
    }
}