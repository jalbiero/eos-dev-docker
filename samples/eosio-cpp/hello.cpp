// Sample from:
// https://developers.eos.io/welcome/latest/getting-started-guide/hello-world

#include <eosio/eosio.hpp>

using namespace eosio;

class [[eosio::contract]] hello: public contract {
public:
   using contract::contract;

   [[eosio::action]]
   void hi(name user) {
      print("Hello, ", user);
   }
};
