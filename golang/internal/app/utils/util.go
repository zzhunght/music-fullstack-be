package utils

import (
	"github.com/jackc/pgx/v5/pgtype"
)

func StringToPGType(input string) pgtype.Text {

	return pgtype.Text{
		String: input,
		Valid:  true,
	}
}

// IntToPGType converts a JSON int32 input to pgtype.Int4
func Int32ToPGType(input int32) pgtype.Int4 {
	if input == 0 {
		return pgtype.Int4{
			Valid: false,
		}
	}

	return pgtype.Int4{
		Int32: int32(input),
		Valid: true,
	}
}
