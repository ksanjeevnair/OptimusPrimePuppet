class site::users {
      # Declaring a dependency: we require several shared groups from the site::groups class (see below).
 #     Class[site::groups] -> Class[site::users]

      # Setting resource defaults for user accounts:
      Pe_accounts::User {
        shell => '/bin/bash',
      }
      pe_accounts::user {'optimus':
        comment => 'Optimus Prime',
        uid => '1109',
        gid => '1109',
sshkeys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSPercKpcAKNJjnSO85wqQDY/ZpS4BWCtLuF6o+XSM7G+4cfD22/tyo5YPI2pPH3quxiy5XQup5pQ2v9haz5UGlbsvpJOxoGh9vMqlYudP3HlBvcZt9rJ1NGHBT3nq841q/C624XAa3w60rmaunB28fJYtPQA2lHcMERgsWAGqzErWonjJEtHQ9HvvUvcx9fFUjT0FYc1kc7nTHrC3B3aevxLWGFLqaSyq2l7KcoC203U+Bw6xNKYQynasovJ9/JN0IITi275uEhf2LUubRQE99z6SVn2w3NpAO3I/LQN3Kjsxx4VdWMPaKLK/niVG0DMsDuTM5cgIpjxDrUKaSVYd optimus@ip-172-31-43-22.us-west-2.compute.internal','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBorCaEwYka4eyjoc4Cw6gs4Kzc23acRghpiZLRhbfwA5PcKSHEx8xv31hGDiHqQcTHvh25xtvs8ToxC5I0n/Z02MS+tm1secywukxiHH9ZO+AKa+/0xqzNRzC/nFBpAN8ZpgLxompPQgBAx4TkhbT2xso3EIe/18Lo8F/NvJTLttS/D+NGSkUPBNuY1NWQzSjGoe6E+h7XZ7WgHYmqq2N43IkUDGv4k+uinnOiLYn9ufRsG/BjwBuLexNjb/bfXK4NupxV7Owix1i672SC/mj2s4wVmMb0XRqrt/SoSBoIxO3fNgUI042wGFDm+tIPyJA2sXF6wPBJ3Hn30lTaccR jenkins@ip-172-31-41-170'],
      }
}
