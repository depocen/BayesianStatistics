//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int NTrain;
  int NTest;
  real XTrain[NTrain];
  real XTest[NTest];
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu;
  real nu;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  XTrain ~ student_t(nu, mu, sigma);
  mu ~ normal(0,1);
  sigma ~ lognormal(0,1);
  nu ~ lognormal(0,1);
}

generated quantities{
  vector[NTest] logLikelihood;
  for(i in 1:NTest){
    logLikelihood[i] = student_t_lpdf(XTest[i]|nu, mu, sigma);
  }
}


