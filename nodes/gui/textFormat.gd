extends Node

const DONBURP = " \n\t"
const FORMAT_SYMS = "$|"
const KEYWORDS = {
	# $ = COLORS
	"$r": "[color=red]",
	"$g": "[color=green]",
	"$b": "[color=blue]",
	"$y": "[color=yellow]",
	"$o": "[color=orange]",
	"$c": "[color=cyan]",
	"$p": "[color=purple]",
	"$e": "[/color]",
	# | = SHAKE
	"|s": "[shake rate=50.0 level=5]",
	"|e": "[/shake]",
}
