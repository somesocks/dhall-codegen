package models


type Person struct {
	Name string `json:"name"`
	Parents []Person `json:"parents"`
}
