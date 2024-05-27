class Solution {
    public double solution(int[] arr) {
        double answer = 0;

        // 총 합 계산
        int sum = 0;
        for(int i=0;i<arr.length;i++) {
            sum += arr[i];
        }
        // 평균 계산
        answer = (double)sum / arr.length;

        // 결과 return
        return answer;
    }
}