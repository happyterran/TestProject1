#1. 의좋은 형제
N1,N2 = map(int,input().split())
D = int(input())
arr = [N1,N2]

for i in range(D):
    if arr[i%2]//2 >1:
        arr[int(not i%2)] += arr[i%2]//2
        arr[i%2] -= arr[i%2] //2
    else:
        arr[int(not i%2)] += arr[i%2]
        arr[i%2] -= arr[i%2]
#asdf
print(arr[0],arr[1])
#asdf
print(arr[0],arr[1])
