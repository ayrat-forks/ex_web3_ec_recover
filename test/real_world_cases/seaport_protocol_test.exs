defmodule ExWeb3EcRecover.RealWorldCases.SeaportProtocolTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias ExWeb3EcRecover.SignedType.Message

  test "Order message support" do
    message = %Message{
      types: %{
        "ConsiderationItem" => [
          %{"name" => "itemType", "type" => "uint8"},
          %{"name" => "token", "type" => "address"},
          %{"name" => "identifierOrCriteria", "type" => "uint256"},
          %{"name" => "startAmount", "type" => "uint256"},
          %{"name" => "endAmount", "type" => "uint256"},
          %{"name" => "recipient", "type" => "address"}
        ],
        "OfferItem" => [
          %{"name" => "itemType", "type" => "uint8"},
          %{"name" => "token", "type" => "address"},
          %{"name" => "identifierOrCriteria", "type" => "uint256"},
          %{"name" => "startAmount", "type" => "uint256"},
          %{"name" => "endAmount", "type" => "uint256"}
        ],
        "OrderComponents" => [
          %{"name" => "offerer", "type" => "address"},
          %{"name" => "zone", "type" => "address"},
          %{"name" => "offer", "type" => "OfferItem[]"},
          %{"name" => "consideration", "type" => "ConsiderationItem[]"},
          %{"name" => "orderType", "type" => "uint8"},
          %{"name" => "startTime", "type" => "uint256"},
          %{"name" => "endTime", "type" => "uint256"},
          %{"name" => "zoneHash", "type" => "bytes32"},
          %{"name" => "salt", "type" => "uint256"},
          %{"name" => "conduitKey", "type" => "bytes32"},
          %{"name" => "counter", "type" => "uint256"}
        ]
      },
      primary_type: "OrderComponents",
      domain: %{
        "chainId" => 137,
        "name" => "Seaport",
        "verifyingContract" => "0x00000000006c3852cbef3e08e8df289169ede581",
        "version" => "1.1"
      },
      message: %{
        "conduitKey" => "0x0000000000000000000000000000000000000000000000000000000000000000",
        "consideration" => [
          %{
            "endAmount" => 10_000_000_000_000_000,
            "identifierOrCriteria" => 0,
            "itemType" => 0,
            "recipient" => "0x0ca98211D33567153d8e7316ddfa34359f9a40F9",
            "startAmount" => 10_000_000_000_000_000,
            "token" => "0x0000000000000000000000000000000000000000"
          }
        ],
        "counter" => 0,
        "endTime" =>
          115_792_089_237_316_195_423_570_985_008_687_907_853_269_984_665_640_564_039_457_584_007_913_129_639_935,
        "offer" => [
          %{
            "endAmount" => 1,
            "identifierOrCriteria" => 423_875,
            "itemType" => 2,
            "startAmount" => 1,
            "token" => "0x67f4732266c7300cca593c814d46bee72e40659f"
          }
        ],
        "offerer" => "0x0ca98211D33567153d8e7316ddfa34359f9a40F9",
        "orderType" => 0,
        "salt" => 9_602_137_361_397_918_250,
        "startTime" => 1_673_439_577,
        "zone" => "0x0000000000000000000000000000000000000000",
        "zoneHash" => "0x3000000000000000000000000000000000000000000000000000000000000000"
      }
    }

    # Generated by the metamask, with Domain separator chopped off
    assert ExWeb3EcRecover.RecoverSignature.encode_eip712(message) |> Base.encode16(case: :lower) ==
             "19019b0651fb24301f8cb24693ccaf43dc1cb69134121e8741c4159b3e1dd40c457cbc25b1f9454d96c5c5313be1a7414f48d92b0e37927bd115b9734fc7c3f426ae"

    assert ExWeb3EcRecover.RecoverSignature.hash_eip712(message) |> Base.encode16(case: :lower) ==
             "c2411dfff82a30b43480466e11b75e98a947e2bbc0c1f689fa31fa7c7c40e607"
  end
end