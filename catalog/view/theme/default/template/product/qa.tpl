<?php if ($qas) { ?>
<?php foreach ($qas as $qa) { ?>
<div class="panel panel-default">
	<div class="panel-heading q-p">
		<i class="fa fa-question-circle q-i"></i>
		<span class="q-qt"><?php echo $qa['question']; ?></span>
		<span class="q-details"><?php echo (($qa_display_question_author && $qa['q_author']) || $qa_display_question_date) ? "(" : ""; ?>
	<?php if ($qa_display_question_author && $qa['q_author']) { ?><span class="q-qa"><?php echo $qa['q_author']; ?></span><?php echo ($qa_display_question_date) ? ", " : ""; ?><?php } ?>
	<?php if ($qa_display_question_date) { ?><span class="q-qd"><?php echo $qa['date_asked']; ?></span><?php } ?>
	<?php echo ($qa_display_question_author || $qa_display_question_date) ? ")" : ""; ?></span>
	</div>
	<div class="panel-body q-p">
		<?php echo ($qa['answer']) ? $qa['answer'] : '<em>' . $text_no_answer . '</em>'; ?>
		<span class="q-details"><?php echo (($qa_display_answer_author || $qa_display_answer_date) && $qa['a_author']) ? "(" : ""; ?>
	<?php if ($qa_display_answer_author && $qa['a_author']) { ?><span class="q-aa"><?php echo $qa['a_author']; ?></span><?php echo ($qa_display_answer_date) ? ", " : ""; ?><?php } ?>
	<?php if ($qa_display_answer_date && $qa['a_author']) { ?><span class="q-ad"><?php echo $qa['date_answered']; ?></span><?php } ?>
	<?php echo (($qa_display_answer_author || $qa_display_answer_date) && $qa['a_author']) ? ")" : ""; ?></span>
	</div>
</div>
<?php } ?>
<div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
<p><?php echo $text_no_questions; ?></p>
<?php } ?>
