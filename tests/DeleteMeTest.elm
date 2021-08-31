module DeleteMeTest exposing (suite)

-- This is an example test. Remove this module and replace it with real tests.

import DeleteMe exposing (ultimateAnswer)
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "DeleteMe"
        [ test "knows the answer to the ultimate question of live" <|
            \_ ->
                ultimateAnswer
                    |> Expect.equal 42
        ]
