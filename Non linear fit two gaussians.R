# This is not mine, comes from stackoverflow/cross-validated question

f<-function(A,x,L,S,L2,A2,S2){
  x<- seq(-5, 5, by = .01)
  f=A*exp((-1)*((x-L)^2)/S)+A2*exp((-1)*((x-L2)^2)/S2)
  plot(x,f)
}


fit1 <- nls(y~(a/b)*exp(-(x-c)^2/(2*b^2))+(d/e)*exp(-(x-f)^2/(2*e^2)),data=a,
            start=list(a=(1/sqrt(2*pi)) / s.approx[1], b=s.approx[1], c=mu.approx[1],
                       d=(1/sqrt(2*pi)) / s.approx[2], e=s.approx[2], f=mu.approx[2]),
            trace=TRUE)


fit1 <- nls(y~(a/b)*exp(-(x-c)^2/(2*b^2))+(d/e)*exp(-(x-f)^2/(2*e^2)),
            start=list(a=(1/sqrt(2*pi)) / s.approx[1], b=s.approx[1], c=mu.approx[1],
                       d=(1/sqrt(2*pi)) / s.approx[2], e=s.approx[2], f=mu.approx[2]),
            algorithm="port")

graf<-function(x,a,b,c,d,e,f){
  x<-seq(-5, 5, by = .01)
    grafico<-y~(a/b)*exp(-(x-c)^2/(2*b^2))+(d/e)*exp(-(x-f)^2/(2*e^2))
  plot(x,graf)
}