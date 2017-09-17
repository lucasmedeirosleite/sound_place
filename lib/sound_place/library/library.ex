defmodule SoundPlace.Library do
  alias SoundPlace.Library.Playlist

  def playlists(_user_id) do
    [
      %Playlist{id: "2rp9cZoxcZNrNCNeM6lkE5", name: "H.E.A.T", cover: "https://mosaic.scdn.co/640/52c431b34ce115006239fd83c9503bd75238a6d0ac7f900c18502f10f7290d08cb1938c289f64dc0b16876d1dd71d86760660e4f82d7e59ebdb78c1fe6e998dcb34f76e47138d5411ea258d42e1cc92a"},
      %Playlist{id: "4rPKf24OpgQlWU6N2VhRjL", name: "Helloween - Deris", cover: "https://mosaic.scdn.co/640/551818ec06059e07e0f2bcdd8f61a3fff158b5206e2f9509ffe1f9e76c9dbb7045d5bb0dac37264fba5f6f40762ed65e22e1ea60432dd50117c547a0bcade3720b7a2b713af80799b627a2976bceb2de"},
      %Playlist{id: "5zhKOuurqhtVr1owD6MhuM", name: "Raimundos/CBJr", cover: "https://mosaic.scdn.co/640/2754752aec1417fabc527daab398ee1acb810a01a670572988c605313286cb4d468206e5037f937fb7a891fc2b6fb903e20ab333466a7a74c184662ad70e0c33194fb7b6c0ed0c0ebac2f88639a64d3c"},
      %Playlist{id: "65P08LaUmH3ACeHm85Cwcz", name: "Sonata Arctica 13/05 Fortaleza", cover: "https://mosaic.scdn.co/640/3c6d38c47ea471ae12af5331e679bcd25cc62d4b5b3b3ef8b984320564e7be98a55c0a20a7fe54298eeca813b89187fd9f2e79e048c4c8082645da86f884f428a7a936212b175a2d78554174b732d9a6"},
      %Playlist{id: "5wVtJJ7rphwCMEL10rLmcj", name: "TV União Jovem de Cara e de Coração (Golden Times)", cover: "https://pl.scdn.co/images/pl/default/c2809c866b8d87f14dc0f5f16dfc8c263124d564"},
      %Playlist{id: "2dt7GNPlJpFxIpPRwH2o2G", name: "Offspring/Red Hot", cover: "https://mosaic.scdn.co/640/68c2057e8ee70231dd3144fd378a811f33bd44506a1502ad80a141b1fad6fe8b5168e1b919c5099aa8814bd4e85f9bd6ffec30d2365ca945e5ff5271d7e8200d7a1100eb68de7af944a649c0a9e2f875"},
      %Playlist{id: "0oIsZSMpzNcL6WWCS4XSNW", name: "Metalcore", cover: "https://mosaic.scdn.co/640/b7ee10741497fe45932e7a6f12600b3beb564364c88adf61f3af023002ee1b8e163bc9a7860ff658daea9677851b770a6297677cc685d6012debff8bfc694dc22c0df62fe6ad5fe510d4f7cfcd018b6d"},
      %Playlist{id: "0yLWpaQvhlkuGLn2IRXPWQ", name: "Classics", cover: "https://mosaic.scdn.co/640/438a32a66412dac50b8c996cc622c08890488d9a557a6058e3de72bf37ffcd2c12dd5932276df3445fa3a6cc1848ea743a293d2088046746d1b09608c9bb1f8cb7540f5a201dd01ed371b28b88f7ca8e"},
      %Playlist{id: "1jzeBuPrGCbs0b0LhApPY3", name: "New songs", cover: "https://mosaic.scdn.co/640/77a4079beb0e756f8027df1915d26e41bb04319b98983a093b6182dfa13d2de2e93aa9ad9f90b92cab7a236a8393ef4587c6afddaf642e6d782afd63d9ce2891f86fdbf8d81e0d385ae244641f5d4b5c"},
      %Playlist{id: "4TmK5ykzvPu4IApkYt5T62", name: "Eddie Vedder", cover: "https://mosaic.scdn.co/640/425e1fef6d70a48a103dfd168a556b7f72f7286577c17804f5bcb51a93aed3b4e86a7881644d1fdb892431f169fc465814053353dd170ccee72af5b5c960918826f62d6a8929f946fc8794f36b59d950"}
    ]
  end
end
