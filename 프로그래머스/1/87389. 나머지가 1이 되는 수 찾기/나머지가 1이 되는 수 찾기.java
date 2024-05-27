class Solution {
    public int solution(int n) {
        // n%x == 1 인 가장 작은 자연수 x를 return하라
        int answer = 0;
        
        for(int i=1; i<=n; i++) {
            if(n%i==1) {
                answer=i;
                break;
            }
        }
        
        return answer;
        
    }
}