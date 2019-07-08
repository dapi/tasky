export default function checkVisible(elm, threshold, mode) {
	threshold = threshold || 0;
	mode = mode || 'visible';

	var rect = elm.getBoundingClientRect();
	var viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight);
	var above = rect.bottom - threshold < 0;
	var below = rect.top - viewHeight + threshold >= 0;

	return mode === 'above' ? above : (mode === 'below' ? below : !above && !below);
}
